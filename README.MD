#软件园协会论坛

##I. 写点什么做介绍？

给师弟们写个网站什么的 ˊ_>ˋ，做了点微小的工作

##II. 怎么跑起来？

记得一定要用 Java 8，我用了不少的 Lambda 表达式以及流式 API，否则不能编译成功

请先安装 maven， 然后终端里跑起来这句话

    mvn package

好了，在 target 文件夹里面就有 war 包了，自己拿到心仪的 servlet 容器里跑起来就好了。

或者这样，直接在 jetty 上面跑起来

    mvn jetty:run

这样就能直接在 8080 端口上访问了

**对了别忘记查看 applicationContext.xml 里面有关数据库的配置，配置好链接并创建好数据库。
不需要建表的， Hibernate 会帮你弄好这些琐碎事 ˊ_>ˋ**

##III. 主要技术

- 后端技术
    - Spring MVC
    - JPA
    - Spring
    - Freemarker
- 前端技术
    - Bootstrap
    - jQuery
    - AngularJS (相关代码目前未合并到开发主线内)

##IV. 参考资料

- 前端
    - 文档资料
        - [Bootstrap 中文文档](http://v3.bootcss.com/)
        - [Bootstrap - Buttons inside List Group Item](http://stackoverflow.com/questions/38373842/bootstrap-buttons-inside-list-group-item) 
        - [Animate.css](https://daneden.github.io/animate.css/)
        - [创建一个自定义 jQuery 插件](https://www.ibm.com/developerworks/cn/web/wa-jqplugin/)    
        - [JQuery API Documentation](https://api.jquery.com)
    - 插件
        - [Holder.js](http://holderjs.com/)
        - [Font Awesome](http://fontawesome.io/)
        - [Marked](https://github.com/chjj/marked)
        - [jQuery Pagination plugin](https://esimakin.github.io/twbs-pagination/)
        - [simplePagination.js](http://flaviusmatis.github.io/simplePagination.js/)
        - [jQuery Serialize Object](https://github.com/macek/jquery-serialize-object)
        - [Bootstrap Markdown](http://www.codingdrama.com/bootstrap-markdown/)
        - [Bootstrap validator](http://1000hz.github.io/bootstrap-validator/)
        - [Showdown](https://github.com/showdownjs/showdown)
    - 框架以及库
        - [AngularJS ui-router (nested routes)](https://www.codeproject.com/articles/842880/angularjs-ui-router-nested-routes)
- 后端
    - Spring Data 与 Hibernate 相关
        - [Spring 4 MVC REST Controller Example (JSON CRUD Tutorial)](http://viralpatel.net/blogs/spring-4-mvc-rest-example-json/)
        - [Spring验证的错误返回------BindingResult](http://zyjustin9.iteye.com/blog/2002606)
        - [Hibernate Validation各注解的用法](http://tcrct.iteye.com/blog/1329823)
        - [Passing date to request param in Spring MVC](http://stackoverflow.com/questions/14766818/passing-date-to-request-param-in-spring-mvc)
        - [【原创】纯干货，Spring-data-jpa详解，全方位介绍](http://www.cnblogs.com/dreamroute/p/5173896.html)
        - [JPA select from collection with many-to-many association](http://stackoverflow.com/questions/15153877/jpa-select-from-collection-with-many-to-many-association)
        - [No serializer found for class org.hibernate.proxy.pojo.javassist.Javassist?](http://stackoverflow.com/questions/24994440/no-serializer-found-for-class-org-hibernate-proxy-pojo-javassist-javassist)
    - 视图技术
        - [FreeMarker教程](http://relive123-yahoo-com-cn.iteye.com/blog/818013)
        - [FreeMarker 获取页面request、session](http://blog.csdn.net/feiyu8607/article/details/6557159)
        - [FreeMarker 中对空字符串"" 和 null 的判断](http://www.liuqianfei.com/article/87f8317eb7ee4d3f80cd41e64d4e6240)
- 通用
    - [正则表达式](https://zh.wikipedia.org/wiki/%E6%AD%A3%E5%88%99%E8%A1%A8%E8%BE%BE%E5%BC%8F)
    - [给Nginx配置一个自签名的SSL证书](http://www.liaoxuefeng.com/article/0014189023237367e8d42829de24b6eaf893ca47df4fb5e000)
- 以及一只懒猫

##VI. Powered By

- Apache
- MariaDB
- Intellij IDEA
- Spring
- Hibernate
- Bootstrap
- jQuery
- AngularJS
- Linux Mint
- Apple

##VII. License 
GNU v3

For details, see LICENSE.