#! /usr/bin/env python3


import crypt
import getpass


pw = getpass.getpass();

if pw == getpass.getpass("Confirm: "):
  print(crypt.crypt(pw))
else:
  exit()
