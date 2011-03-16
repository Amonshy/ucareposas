#! /usr/bin/env python
# -*- coding: utf-8 -*-
# Foundations of Python Network Programming - Chapter 2 - udp_remote.py
# UDP clien and server for talking over the network

import sys
import socket
import random

s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)

MAX = 65535

if 2 <= len(sys.argv) <= 4 and sys.argv[1] == 'server':
    interface = sys.argv[2] if len(sys.argv) > 2 else ''
    PORT = int(sys.argv[3]) if len(sys.argv) > 3 else 1060
    s.bind((interface, PORT))
    print 'listening at', s.getsockname()
    while True:
        data, address = s.recvfrom(MAX)
        if random.randint(0,1):
            print 'The client at', address, 'says', repr(data)
            s.sendto('Your data was %d bytes' % len(data), address)
        else:
            print 'Pretending to drop packet from', address

elif len(sys.argv) >= 3 and sys.argv[1] == 'client':
    hostname = sys.argv[2]
    PORT = int(sys.argv[3]) if len(sys.argv) > 3 else 1060
    s.connect((hostname, PORT))
    print 'El socket del cliente es: ', s.getsockname()
    delay = 0.1
    while True:
        s.send('Soy el cliente')
        print 'Waiting up to', delay, 'seconds for a reply'
        s.settimeout(delay)
        try:
            data = s.recv(MAX)
        except socket.timeout:
            delay *= 2    # wait even longer for the next request
            if delay > 2.0:
                raise RuntimeError('El servidor se ha caido.')
        except:
            raise   # a real error, so we let the user see it
        else:
            break   # we are done, and can stop looping
    print 'El servidor me ha dicho: ', repr(data)
else:
    print >> sys.stderr, 'usage: udp_remote.py server [<interface>] [<port>]'
    print >> sys.stderr, '   or: udp_remote.py client <host> [<port>]'
    sys.exit(2)
