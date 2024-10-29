#!/usr/bin/env sh
# mozilla support article where these instructions can be found:
# https://support.mozilla.org/en-US/kb/install-firefox-linux#w_install-firefox-deb-package-for-debian-based-distributions
# create the keyrings dir if it doesn't exist
if [ ! -d '/etc/apt/keyrings' ]; then
  sudo install -d -m 0755 /etc/apt/keyrings
fi

# import the mozilla apt repository signing key
wget -q https://packages.mozilla.org/apt/repo-signing-key.gpg -O - | \
  sudo tee /etc/apt/keyrings/packages.mozilla.org.asc >/dev/null

# verify that the gpg fingerprint matches what i just downloaded
gpg -n -q --import --import-options import-show \
  /etc/apt/keyrings/packages.mozilla.org.asc | \
  awk '/pub/{getline; gsub(/^ +| +$/,""); 
  if($0 == "35BAA0B33E9EB396F59CA838C0BA5CE6DC6315A3")
    print "\nThe key fingerprint matches ("$0").\n"; 
  else 
    print "\nVerification failed: the fingerprint ("$0") does not match the expected one.\n"}'

# add the mozilla apt repository to my sources
echo 'deb [signed-by=/etc/apt/keyrings/packages.mozilla.org.asc] https://packages.mozilla.org/apt mozilla main' | \
  sudo tee -a /etc/apt/sources.list.d/mozilla.list > /dev/null

# if on ubuntu, configure mozilla's apt repository to have a higher priority
# than the snap firefox package that ubuntu has as the default
if [ "$(grep -E '^ID="?ubuntu"?$' /etc/os-release)" ]; then
  echo '
  Package: *
  Pin: origin packages.mozilla.org
  Pin-Priority: 1000
  ' | sudo tee /etc/apt/preferences.d/mozilla
fi

# update and install firefox
sudo apt update && sudo apt install firefox 

# further reading:
# https://blog.mozilla.org/en/products/4-reasons-to-try-mozillas-new-firefox-linux-package-for-ubuntu-and-debian-derivatives/
