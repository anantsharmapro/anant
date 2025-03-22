cd ~/.kube

SHORTNAME=dora
MASTER_NODE=dora-cluster-control-19247d2a391
USER=$1

NAME=$SHORTNAME
endpoint=https://$MASTER_NODE:6443

mv ca.crt $SHORTNAME-ca.crt
mv $USER.crt $SHORTNAME-$USER.crt

kubectl config set-cluster $NAME \
  --embed-certs=true \
  --server=$endpoint \
  --certificate-authority=$SHORTNAME-ca.crt

kubectl config set-credentials $SHORTNAME-$USER --client-certificate=$SHORTNAME-$USER.crt  --client-key=$USER.key
kubectl config set-context $SHORTNAME-$USER --cluster=$NAME --user=$SHORTNAME-$USER

kubectl config use-context $SHORTNAME-$USER
