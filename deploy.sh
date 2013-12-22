scp -r ./pdx911 james@childr.es:/opt/rails_apps/pdx-911-api

ssh -l james childr.es "touch /opt/rails_apps/pdx-911-api/pdx911/tmp/restart.txt"