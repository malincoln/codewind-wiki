#!/bin/bash
#
#*******************************************************************************
# Copyright (c) 2019 IBM Corporation and others.
# All rights reserved. This program and the accompanying materials
# are made available under the terms of the Eclipse Public License v2.0
# which accompanies this distribution, and is available at
# http://www.eclipse.org/legal/epl-v20.html
#
# Contributors:
#     IBM Corporation - initial API and implementation
#*******************************************************************************

# README FIRST !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
#
# Please follow the steps below to publish updates 
#
# 1. create a pull request to get a review
# 2. merge your PR to 'master' branch once you get an approval from a committer 
# 
# Get help from a committer for the next steps
# 3. get updated changes from https://github.com/eclipse/codewind-wiki 
# 4. run './script/publish.sh' to publish 
#
# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

COMMIT_COMMENT=`git log -1 --oneline`;

echo "Publishing $COMMIT_COMMENT ..."

DIR=$(dirname $0)
cd $DIR/../../

echo "Refreshing '$(pwd)/codewind.wiki' by copying contents from '$(pwd)/codewind-wiki'"
rm -rf codewind.wiki

# Clone the actual Codewind wiki repository
git clone https://github.com/eclipse/codewind.wiki.git

# Copy contents from 'codewind-wiki' to 'codewind.wiki' except '.git' and 'script'
rsync -avrv --exclude=.git --exclude=script codewind-wiki/ codewind.wiki

cd ./codewind.wiki
git commit -a -m "${COMMIT_COMMENT}"

# Push to Codewind wiki
git push -u origin master