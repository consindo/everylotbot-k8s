# everylotbot-k8s

This is a Kubernetes deployment for <https://github.com/fitnr/everylotbot>.

If you already have a Kubernetes cluster, it should make it easier to run your own bot! Running a Kubernetes cluster to run a bot is probably not such a great idea. However, the Docker container might still be useful (just remember to mount your database in as a persistent volume).

**Docker Container:** `docker run consindo/everylotbot`

The Terraform to create the Kubernetes resources is pretty straight forward, but you'll probably need to make small changes to the provider & s3 details to use it for yourself.

Since it runs as a container, the entrypoint script in `cronjob.tf` pulls the database from s3, extracts it, runs the bot, compresses the db, and re-uploads it back to s3.

## Accounts

This bot currently runs:

- <https://twitter.com/everylotakl>
- <https://twitter.com/everylotchc>
- <https://twitter.com/everylottokyo>
- <https://twitter.com/everylotwlg>
