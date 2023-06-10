# brave-backup-script
Brave does not support cloud backups

`upload.sh` creates a tarball of your Brave browser + extensions - [reference](https://community.brave.com/t/backup-all-my-brave-browser-data-and-extensions/126214).

Replace `user` in the script's archive path with the appropriate user.

To avoid Githubs maximum file size limit (which forces you to purchase Github lfs storage), the tarball is split into chunks of 50mb. You can reassemble them with the command `cat brave-part-* > brave.tar | tar cvf backup`

Git history is preserved so you can view archives of your config. Running this as a cronjob is recommended.
