#!/bin/bash
spiders=(authorRedis videoRedis bangumiAndDonghua authorAutoAdd videoAutoAdd site online)
for var in ${spiders[@]} 
do 
    ps -ef | grep $var | grep -v grep | cut -c 9-15 | xargs kill -9 
    nohup scrapy crawl $var -L INFO 1>$var.log 2>&1 &
done 
ps -ef | grep tag_adder | grep -v grep | cut -c 9-15 | xargs kill -9 
nohup python ./biliob_requests/tag_adder.py 1>tag_adder.log 2>&1 &
ps -ef | grep DanmakuAggregate | grep -v grep | cut -c 9-15 | xargs kill -9 
cd danmaku_spider/ && nohup scrapy crawl DanmakuAggregate 1>log.log 2>&1 &
ps -ef |grep py

export WORD_MONGO_URL=mongodb://jannchie:141421@dds-2ze2bbbe930fe284-pub.mongodb.rds.aliyuncs.com:3717/word
export WORD_SERVER_IP=47.94.252.158
export WORD_SERVER_PASSWORD=Panjianqi123
export WORD_SERVER_USERNAME=root