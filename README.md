# Learning robot framework



**Hi all!**

**This is a simple example about using robot framework. The documentation will be improved as soon as possible**
**The scripts searches for a defined product in the amazon page**
**Therefore, it follow the steps bellow:**
* 80% Of Shown Products Should Be Exclusively The Searched Product
* The Higher Price In The First Page Can't Be Greater Than U$2000
* Products Different Than The Searched Product Should Be Cheaper Than The Searched Product

**The output is saved in json files** 

## How it works?

- First, you need to install the requirements by running:
```pip install -r requirements.txt```
- Also, you'll need to download and install Selenium Webdriver according to the browser (e.g. GeckoDriver, ChromeDriver, etc)
- If everything is set up, then you'll be able to run Robot Framerwork
```commandline
robot -L trace amazon_search
```

Work in progress; Use at your own risk.
