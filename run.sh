#!/bin/bash
NODE_ENV=development DEBUG=ESoHA nodemon -e js,coffee,ect,html --exec "coffee app.coffee"