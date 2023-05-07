Stress testing bot example
===================

Summary
----

This project is intended to stock a template source codes for stress testing.

This example uses selenium python library to implement test scenarios. Therefore you can test SPA application with real browser.

To raise multiple agents, you can use a batch script that builds a docker image and run the image. Each containers' parameter is defined in a csv file. 

In this example, Sample target application is https://starter-angular.moaiapps.net . The appliations source code is published on github https://github.com/moaiapps/startar-angular

Preparation (single agent)
--------

requires python 3.x environment. If you are using only docker image, python environment is not required.

```shell
$ pip install selenium
```

Run a single agent
--------

```shell
bash$ BOT_LOGIN_ID=<your loginId> BOT_PASSWORD=<your password> BOT_OPERATION=Login+Logout python -m stress_testing
```

Run multiple agents at once
--------

requires Docker

`$PROJECT_ROOT/batch/bot-list.csv` is a bot agent parameter list.

```shell
$ cd $PROJECT_ROOT
$ bash ./batch/raise.sh
```
