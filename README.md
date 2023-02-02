# Tor

Simple docker image for Tor.

> **Note**
> `network_mode: host` is **required** if you run a tor relay in container. Otherwise most incoming connections will be rejected by Tor's built-in dos mitigation as `same address concurrent connections`.