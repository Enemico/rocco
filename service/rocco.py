#!/usr/bin/env python3

import subprocess
import os


pool = os.environ.get('POOL')
wallet = os.environ.get('WALLET')
threads = os.environ.get('THREADS', '1')


def rocco():
    subprocess.run(["/root/xmrig/build/xmrig", "-o", pool, "-u", wallet, "-p", "2", "-t", threads, "-k"])


if __name__ == '__main__':
    rocco()