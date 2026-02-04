# save: docker save command saves the images in a tarball, and then export that tarball to a different host
# load: docker load is used to import all the images from that tarball

echo -e '\033[0;32mStep 1: Pulling the images \033[0m'
docker image pull alpine
docker image ls

echo -e '\033[0;32mStep 2: Saving docker image as a tarball\033[0m'
docker image save alpine -o alpine_backup.tar
ls -a alpine_backup.tar
tar -tvf alpine_backup.tar # list the contents; -t: table of contents
# v: verbose (detailed info)
# f: name of the archived file (-tvf is same as ls -l when we run it into some folder or file)
docker image rm alpine # for testing, we removed the already present image
docker image ls 

echo -e '\033[0;32mStep 3: Loading new image from tarball \033[0m'
docker image load --input alpine_backup.tar
docker image ls

echo -e '\033[0;32mStep 4: Cleanup \033[0m'
docker image rm `docker image ls -a -q`
