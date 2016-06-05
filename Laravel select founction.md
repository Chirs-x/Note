## 前言

Laravel 框架中的查询构造器相当的强大，可能是我的基础太差。当我看到 DB Facade 中的 select 方法时一时不能理解，于是就有了这篇文章。

## select()方法的2种使用

### 1. 链式调用：

    $users = DB::table('users')->select('uname, realname')->get();

通过 Laravel Debugbar 上面这句代码执行的SQL是：

    select \`uname\`, \`realname\` from \`users\`

### 2. 静态调用：

    $sql = "select uname, realname from users";
    $users = DB::select($sql);

这种方式，执行的SQL语句跟链式调用执行语句是一样的。

##分解

据其文档描述table()会针对指定的数据表返回一个查询构造器实例,追踪到 DB Facade 类中
    
    --文件位置 framework/src/Illuminate/Support/Facades/DB.php

    namespace Illuminate\Support\Facades;
    /**
     * @see \Illuminate\Database\DatabaseManager
     * @see \Illuminate\Database\Connection
     */
    class DB extends Facade
    {
        /**
         * Get the registered name of the component.
         *
         * @return string
         */
        protected static function getFacadeAccessor()
        {
            return 'db';
        }
    }
这个文件中根本没有table()这个静态方法，但是这个类继承了 Facade 这个类

## Laravel 中的 Facades
Laravel Facade 是一种为容器内部服务提供类型静态接口的类。据其文档描述，Facades 是可触及容器服务底层实现方式的代理。使用 facade 类的好处是让开发者使用服务是更加便捷。


Facade 类中包含一个名为 `$app` 的私有属性，其值为服务容器的引用。
\__callStatic魔术方法用于处理实际并不存在的静态方法的调用。因为 Facade 类并未实现该方法。因此，__callStatic 会从容器获取各自的服务，进而调用。
__callStatic 方法具体实现：

    --!文件位置 framework/src/Illuminate/Support/Facades/Facade.php

    /**
     + Handle dynamic, static calls to the object.
     *
     + @param  string  $method
     + @param  array   $args
     + @return mixed
     */
    public static function __callStatic($method, $args)
    {
        $instance = static::getFacadeRoot();
        if (! $instance) {
            throw new RuntimeException('A facade root has not been set.');
        }
        switch (count($args)) {
            case 0:
                return $instance->$method();
            case 1:
                return $instance->$method($args[0]);
            case 2:
                return $instance->$method($args[0], $args[1]);
            case 3:
                return $instance->$method($args[0], $args[1], $args[2]);
            case 4:
                return $instance->$method($args[0], $args[1], $args[2], $args[3]);
            default:
                return call_user_func_array([$instance, $method], $args);
        }
    }

通过`$instance = static::getFacadeRoot()`来得到调用该方法的所属实例

    public static function getFacadeRoot()
    {
        return static::resolveFacadeInstance(static::getFacadeAccessor());
    }

在 DB Facade中 已实现 `getFacadeAccessor()` 该方法 `return 'db'`。

    protected static function resolveFacadeInstance($name)
    {
       if (is_object($name)) {
           return $name;
       }
       if (isset(static::$resolvedInstance[$name])) {
           return static::$resolvedInstance[$name];
       }
       return static::$resolvedInstance[$name] = static::$app[$name];
    }

通过 __callStatic() 及 `static::` 后期静态帮定。实现了这个伪静态的调用。这也就明白了为什么可以这个调用DB::select()方法。

我们再回到第一种调用方式：

    --文件位置 #Illuminate\Database\Query
    public function select($colums = ['*'])
    {
        $this->columns = is_array($columns) ? $columns : func_get_args();
        return $this;
    }

通过源码可以看出 select 是个可变参数函数，默认接受一个数组

