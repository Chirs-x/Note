##Composer.json中autoload字段详解

####composer的自动加载映射支持PSR-0,  PSR-4, classmap, files等4中方式

1. PSR-4
```
"autoload": {
        "psr-4": {
            "Foo\\": "src/"
        }
    }
```
如果你需要在多个目录中自动加载同一个命名空间前缀，你可以这样写：
```
"autoload":{
    "psr-4":{"Foo\\": ["src/", "lib/"]}
}
```
如果你想在同一个目录中自动加载任何命名空间前缀，你可以这样写：
```
"autoload":{"": "src/"}
```
2. PSR-0
http://docs.phpcomposer.com/04-schema.html#autoload