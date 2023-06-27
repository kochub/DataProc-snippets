YC_CLUSTER=metastore-1
YC_VERSION=2.0.66
YC_ZONE=ru-central1-c
YC_SUBNET=default-ru-central1-c
YC_BUCKET=kesha-wh
YC_SA=sa-dataproc-adm
YC_MS_URL='jdbc:postgresql://rc1b-ib50lhtvzqzmap6i.mdb.yandexcloud.net:6432/db1?targetServerType=master&ssl=true&sslmode=require'
YC_MS_USER='hivems'
YC_MS_PASS='chahle1Eiqu5BukieZoh'

yc dataproc cluster create ${YC_CLUSTER} \
  --zone ${YC_ZONE} \
  --service-account-name ${YC_SA} \
  --version ${YC_VERSION} --ui-proxy \
  --services yarn,tez,hive \
  --bucket ${YC_BUCKET} \
  --subcluster name="master",role='masternode',resource-preset='s2.medium',disk-type='network-hdd',disk-size=100,hosts-count=1,subnet-name=${YC_SUBNET} \
  --subcluster name="compute",role='computenode',resource-preset='s2.medium',disk-type='network-hdd',disk-size=100,hosts-count=0,max-hosts-count=1,subnet-name=${YC_SUBNET},autoscaling-decommission-timeout=3600 \
  --ssh-public-keys-file ~/.ssh/id_ecdsa.pub \
  --property core:fs.s3a.committer.name=directory \
  --property core:fs.s3a.committer.staging.conflict-mode=append \
  --property core:fs.s3a.committer.threads=100 \
  --property core:fs.s3a.connection.maximum=1000 \
  --property core:mapreduce.outputcommitter.factory.scheme.s3a=org.apache.hadoop.fs.s3a.commit.S3ACommitterFactory \
  --property hive:javax.jdo.option.ConnectionURL=${YC_MS_URL} \
  --property hive:javax.jdo.option.ConnectionDriverName=org.postgresql.Driver \
  --property hive:javax.jdo.option.ConnectionUserName=${YC_MS_USER} \
  --property hive:javax.jdo.option.ConnectionPassword=${YC_MS_PASS} \
  --property hive:hive.metastore.warehouse.dir=s3a://${YC_BUCKET}/wh \
  --property hive:hive.exec.compress.output=true \
  --property hive:hive.metastore.fshandler.threads=50 \
  --property hive:datanucleus.connectionPool.maxPoolSize=50 \
  --property dataproc:hive.thrift.impl=hive