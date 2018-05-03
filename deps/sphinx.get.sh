#!/bin/bash

set -ex

SPHINX_BASE_URL='https://downloads.sourceforge.net/project/cmusphinx/sphinxbase/5prealpha/sphinxbase-5prealpha.tar.gz?r=https%3A%2F%2Fsourceforge.net%2Fprojects%2Fcmusphinx%2Ffiles%2Fsphinxbase%2F5prealpha%2Fsphinxbase-5prealpha.tar.gz%2Fdownload&ts=1525325357'
POCKET_SPHINX_URL='https://downloads.sourceforge.net/project/cmusphinx/pocketsphinx/5prealpha/pocketsphinx-5prealpha.tar.gz?r=https%3A%2F%2Fsourceforge.net%2Fprojects%2Fcmusphinx%2Ffiles%2Fpocketsphinx%2F5prealpha%2Fpocketsphinx-5prealpha.tar.gz%2Fdownload&ts=1525325429'

WHAT=$1

DEP_MODULE=sphinx
ARCH=noarch
. functions.sh

function get_source() {
    BASE_DIR=$SRC_DIR/sphinxbase
    POCKET_DIR=$SRC_DIR/pocketsphinx

    rm -fr $SRC_DIR
    mkdir -p $BASE_DIR
    mkdir -p $POCKET_DIR

    curl -sfSL "$SPHINX_BASE_URL" | tar -C $BASE_DIR --strip-components=1 -zx
    curl -sfSL "$POCKET_SPHINX_URL" | tar -C $POCKET_DIR --strip-components=1 -zx
}

function model_out_dir() {
    local dir=$OUT_DIR/share/pocketsphinx/model/$1
    rm -fr $dir
    mkdir -p $dir
    cd $dir
}

function get_model_en() {
    local LM_URL='https://downloads.sourceforge.net/project/cmusphinx/Acoustic%20and%20Language%20Models/US%20English/en-70k-0.2.lm.gz?r=https%3A%2F%2Fsourceforge.net%2Fprojects%2Fcmusphinx%2Ffiles%2FAcoustic%2520and%2520Language%2520Models%2FUS%2520English%2Fen-70k-0.2.lm.gz%2Fdownload&ts=1525326384'
    local LM_PRUNED_URL='https://downloads.sourceforge.net/project/cmusphinx/Acoustic%20and%20Language%20Models/US%20English/en-70k-0.2-pruned.lm.gz?r=https%3A%2F%2Fsourceforge.net%2Fprojects%2Fcmusphinx%2Ffiles%2FAcoustic%2520and%2520Language%2520Models%2FUS%2520English%2Fen-70k-0.2-pruned.lm.gz%2Fdownload&ts=1525326421'
    local HMM_8KHZ_URL='https://downloads.sourceforge.net/project/cmusphinx/Acoustic%20and%20Language%20Models/US%20English/cmusphinx-en-us-8khz-5.2.tar.gz?r=https%3A%2F%2Fsourceforge.net%2Fprojects%2Fcmusphinx%2Ffiles%2FAcoustic%2520and%2520Language%2520Models%2FUS%2520English%2Fcmusphinx-en-us-8khz-5.2.tar.gz%2Fdownload&ts=1525326443'
    local HMM_PTM_8KHZ_URL='https://downloads.sourceforge.net/project/cmusphinx/Acoustic%20and%20Language%20Models/US%20English/cmusphinx-en-us-ptm-8khz-5.2.tar.gz?r=https%3A%2F%2Fsourceforge.net%2Fprojects%2Fcmusphinx%2Ffiles%2FAcoustic%2520and%2520Language%2520Models%2FUS%2520English%2Fcmusphinx-en-us-ptm-8khz-5.2.tar.gz%2Fdownload&ts=1525326469'
    local HMM_URL='https://downloads.sourceforge.net/project/cmusphinx/Acoustic%20and%20Language%20Models/US%20English/cmusphinx-en-us-5.2.tar.gz?r=https%3A%2F%2Fsourceforge.net%2Fprojects%2Fcmusphinx%2Ffiles%2FAcoustic%2520and%2520Language%2520Models%2FUS%2520English%2Fcmusphinx-en-us-5.2.tar.gz%2Fdownload&ts=1525326490'
    local HMM_PTM_URL='https://downloads.sourceforge.net/project/cmusphinx/Acoustic%20and%20Language%20Models/US%20English/cmusphinx-en-us-ptm-5.2.tar.gz?r=https%3A%2F%2Fsourceforge.net%2Fprojects%2Fcmusphinx%2Ffiles%2FAcoustic%2520and%2520Language%2520Models%2FUS%2520English%2Fcmusphinx-en-us-ptm-5.2.tar.gz%2Fdownload&ts=1525326504'

    model_out_dir en
    curl -sfSL "$LM_PRUNED_URL" | gunzip >lm.bin
    mkdir -p hmm
    curl -sfSL "$HMM_URL" | tar -C hmm --strip-components=1 -zx
    mkdir -p hmm-8khz
    curl -sfSL "$HMM_8KHZ_URL" | tar -C hmm-8khz --strip-components=1 -zx
    mkdir -p ptm
    curl -sfSL "$HMM_PTM_URL" | tar -C ptm --strip-components=1 -zx
    mkdir -p ptm-8khz
    curl -sfSL "$HMM_PTM_8KHZ_URL" | tar -C ptm-8khz --strip-components=1 -zx
}

function get_model_zh() {
    local LM_DMP_URL='https://downloads.sourceforge.net/project/cmusphinx/Acoustic%20and%20Language%20Models/Mandarin/zh_broadcastnews_64000_utf8.DMP?r=https%3A%2F%2Fsourceforge.net%2Fprojects%2Fcmusphinx%2Ffiles%2FAcoustic%2520and%2520Language%2520Models%2FMandarin%2Fzh_broadcastnews_64000_utf8.DMP%2Fdownload&ts=1525327023'
    local DICT_URL='https://downloads.sourceforge.net/project/cmusphinx/Acoustic%20and%20Language%20Models/Mandarin/zh_broadcastnews_utf8.dic?r=https%3A%2F%2Fsourceforge.net%2Fprojects%2Fcmusphinx%2Ffiles%2FAcoustic%2520and%2520Language%2520Models%2FMandarin%2Fzh_broadcastnews_utf8.dic%2Fdownload&ts=1525327083'
    local PTM_URL='https://downloads.sourceforge.net/project/cmusphinx/Acoustic%20and%20Language%20Models/Mandarin/zh_broadcastnews_16k_ptm256_8000.tar.bz2?r=https%3A%2F%2Fsourceforge.net%2Fprojects%2Fcmusphinx%2Ffiles%2FAcoustic%2520and%2520Language%2520Models%2FMandarin%2Fzh_broadcastnews_16k_ptm256_8000.tar.bz2%2Fdownload&ts=1525327109'

    model_out_dir zh
    curl -sfSL "$LM_DMP_URL" >lm.dmp
    curl -sfSL "$DICT_URL" >zh.dict
    mkdir -p ptm
    curl -sfSL "$PTM_URL" | tar -C ptm --strip-components=1 -jx
}

function get_model() {
    local lang=$1
    case "$lang" in
        en-us|en) get_model_en ;;
        zh) get_model_zh ;;
        *) echo "unknown language $lang" >&2; exit 1 ;;
    esac
}

case "$WHAT" in
    model) get_model $2 ;;
    *) get_source ;;
esac
