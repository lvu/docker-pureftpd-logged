# Docker pure-ftpd server with logging support

Intended for use with anonymous access allowed to `/var/lib/ftp/pub`, and for work with virtual users stored in external passwd file.

Run as

	docker run --rm -it -p 21:21 -p 30000-30009:30000-30009 \
	--mount type=bind,source=/path/pureftpd.passwd,destination=/etc/pure-ftpd/pureftpd.passwd \
	vlavrinenko/pureftpd-logged
