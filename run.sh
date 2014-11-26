#!/bin/bash
NODE_ENV=development DEBUG=ESoHA nodemon -e js,coffee,jade,html --exec "coffee app.coffee"