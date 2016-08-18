### 准备工作

1. 执行下面的命令，构建composer.json

    	composer init

2. 执行上述命令后，进入交互，根据提示输入

		Package name (<vendor>/<name>) [liaoxianwei/haha]:saltrc/haha
		Description[]: composer包构建
		Author[]: saltrc <haha@qq.com>
		//当期包的稳定状态，可填写的值[stable, RC, beta, alpha, dev]
		Minimun stability[]:dev
		//类型， 这里我们不填，回车填过
		Package Type[]:
		//协议
		License[]:MIT
		//填写包的依赖，比如PHP版本要求
		Define your dependencies.
		Would you like to define your dependencies (require) interactively [yes]? yes
		Search for a package: php
		Enter the version constraint to require (or leave blank to use the latest version): >=5.3
		Search for a package:
		Would you like to define your dependencies (require) interactively [yes]? no
		
		//生成的composer.json文件
		{
		    "name": "saltrc/haha",
		    "description": "composer包构建",
		    "require": {
		        "php": ">=5.3"
		    },
		    "license": "MIT",
		    "authors": [
		        {
		            "name": "saltrc",
		            "email": "haha@qq.com"
		        }
		    ],
		    "minimum-stability": "dev"
		}
		//确认构建
		Do you confirm generation [yes]? yes
	经过以上动作后，在当前目录下会出现了composer.json文件
			
### 动手阶段

通过`composer init`构建的*composer.json*是一个空壳子，它并不知道去哪里加载类文件，所以接下来我们要修改*composer.json*文件，让其实现类文件加载

	{
	    "name": "saltrc/haha",
	    "description": "composer包构建",
	    "require": {
	        "php": ">=5.3"
	    },
	    "license": "MIT",
	    "authors": [
	        {
	            "name": "saltrc",
	            "email": "haha@qq.com"
	        }
	    ],
	    "minimum-stability": "dev",
	    "autoload": {
	        "psr-4": {
	            "Haha\\": "src/"
	        }
	    }
	}

1. 编辑*conposer.json*文件，添加*autoload*键。这里我是使用*psr-4*规范来定义，将命名空间映射到*src*目录下
2. 保存后执行`composer install`，显示如下结果：
	
		Loading composer repositories with package information
		Updating dependencies (including require-dev)
		Nothing to install or update
		Writing lock file
		Generating autoload files

3. 再查看下当前目录会发现多了*composer.lock*文件和*vendor*目录，查看*vendor/composer/autoload_psr4.php*,会发现有其下代码

		return array(
		    'Haha\\' => array($baseDir . '/src'),
		);

### 测试阶段

1. 在*composer.json*同级目录下新建目录*src*，创建一个符合*psr-4*规范的类文件

		<?php
		namespace Haha;

		class Dog {
			
		    public function dog()
		    {
		    	echo 'dog';
		    }

		}

2. 新建一个*test.php*

		<?php
		require 'vendor/autoload.php';

		use Haha\Dog;

		$haha = new Dog();
		$haha->dog();

3. 用php命令行执行`php test.php`,输入如下：

		dog

到此，最简单的composer包就构建成功了。

### 发布到packagist

1. 在发布之间，还有一个地方需要修改，之前我们在执行`composer init`命令是，有一项*Minimun stability[]:*的值我们设置为*dev*，如果你已经确定你的代码已经稳定了。那么可以更改改项为stble，保存后执行`composer update`
2. 把项目托管到git
3. 然后把你的git仓库地址提交到https://packagist.org/packages/submit
