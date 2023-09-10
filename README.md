# brave-backup-script

Brave does not support cloud backups - [reference](https://community.brave.com/t/backup-all-my-brave-browser-data-and-extensions/126214).

`upload.sh` creates a tarball of your Brave browser + extensions.

To avoid Githubs maximum file size limit (which forces you to purchase Github lfs storage), the tarball is split into chunks of 50mb. You can reassemble them with the command `cat brave-part-* > brave.tar | tar cvf backup`

A shallow clone is executed with --depth 1 on each execution. `.git` is removed on completion to avoid excessive client-side storage. Running this as a cronjob is recommended.
