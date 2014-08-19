###Getting Started

Before you can setup your machine using Boxen, you'll need to do a couple prelimnary steps.

1. Install XCode and the associated developer tools.
2. Generate your new Public SSH key and add it to github. After the cat command outputs your public key, copy the full contents and add this key to your Github account (under Account Settings > SSH Keys). From terminal:
```
ssh-keygen
cat ~/.ssh/id_rsa.pub
```
