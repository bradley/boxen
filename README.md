###Main Important Stuff
1. State any [package](https://github.com/boxen) you wish to include in your Puppetfile in the following format:
```
github "package_name", "version number"
```
2. Re-state the package in `modules/people/manifests/your_github_name.pp` and add any additional configuration there.
3. There are examples in `modules/people/manifests/bradley.pp` of how to include and place additional files.

###Getting Started

Before you can setup your machine using Boxen, you'll need to do a couple prelimnary steps.

1. Install XCode and the associated developer tools.
2. Generate your new Public SSH key and add it to github. After the cat command outputs your public key, copy the full contents and add this key to your Github account (under Account Settings > SSH Keys). From terminal:
```
ssh-keygen
cat ~/.ssh/id_rsa.pub
```

Now we can install our boxen.

```
sudo mkdir -p /opt/boxen
sudo chown ${USER}:staff /opt/boxen
git clone git@github.com:bradley/boxen /opt/boxen/repo
cd /opt/boxen/repo
./script/boxen
```

If you get the error shown below, you may need to run `source /opt/boxen/env.sh`. After which, you can re-run `./script/boxen`.

```
--> You haven't loaded Boxen's environment yet!
    To permanently fix this, source /opt/boxen/env.sh at the end
    of your shell's startup file.
```

Expect hiccups.


###Helpful Notes

1. If you run into a situation where you need to re-run `./script/boxen` and want it to also reinstall an application it has already installed, you need to rm boxen's record of the previous install. For example:
```
sudo rm -rf /var/db/.puppet_appdmg_installed_SublimeText2
```
