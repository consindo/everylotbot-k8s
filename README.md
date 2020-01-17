# everylotbot-k8s

This is a Kubernetes deployment for <https://github.com/fitnr/everylotbot>.

If you already have a Kubernetes cluster, it should make it easier to run your own bot! Running a Kubernetes cluster to run a bot is probably not such a great idea. However, the Docker container might still be useful (just remember to mount your database in as a persistent volume).

**Docker Container:** `docker run consindo/everylotbot`

The Terraform to create the Kubernetes resources is pretty straight forward, but you'll probably need to make small changes to the provider & persistent volume claim to use it for yourself.

## Accounts

This bot currently runs:

- <https://twitter.com/everylotakl>
