NGINX_ADD_ON_URL="https://splunkbase.splunk.com/app/3258/release/2.0.2/download"
APP_EXPORTER_APP_URL="https://splunkbase.splunk.com/app/2613/release/1.2.1/download"
NGINX_APP_URL=`curl -s https://api.github.com/repos/shaneqi/splunk-app-nginx/releases/latest | jq -r .tarball_url`
CASHFLOW_APP_URL=`curl -s https://api.github.com/repos/shaneqi/splunk-app-cashflow/releases/latest | jq -r .tarball_url`

docker run \
-d \
--name splunk \
-v `pwd`/data:/data:ro \
-v `pwd`/../Nginx.conf/logs/access.log:/data-nginx/access.log:ro \
-v `pwd`/config/etc:/opt/splunk/etc \
--network GoldenArches \
-e TZ=America/Chicago \
-e "SPLUNK_START_ARGS=--accept-license" \
-e "SPLUNK_LICENSE_URI=Free" \
-e "SPLUNK_PASSWORD=thisdoesnotmatterbecauseiamusingfreelicense" \
-e "SPLUNK_APPS_URL=${NGINX_ADD_ON_URL},${APP_EXPORTER_APP_URL},${NGINX_APP_URL},${CASHFLOW_APP_URL}" \
-e "SPLUNKBASE_USERNAME=${SB_USERNAME}" \
-e "SPLUNKBASE_PASSWORD=${SB_PASSWORD}" \
splunk/splunk:8.0.3
