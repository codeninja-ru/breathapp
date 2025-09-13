# breathapp

## Crossbuild

```bash
podman build -t breath .
podman run -v $(pwd):/usr/src -it --rm breath ./make.sh
```

and then look for executable files in the `bin` folder
