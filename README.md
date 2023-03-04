# networkLoadSniffer
Catch DDoS ​​attack using networkLoadSniffer script


### How to start?

```
git clone https://github.com/KredensKuchenny/networkLoadSniffer.git
cd networkLoadSniffer
chmod +x *
```

add in crontab

```
crontab -e
*/1 * * * * cd /yourPath/networkLoadSniffer && bash daemon >> /dev/null 2>&1
```
