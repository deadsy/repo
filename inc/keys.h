//-----------------------------------------------------------------------------
/*

Read and Debounce Keys

*/
//-----------------------------------------------------------------------------

#ifndef KEYS_H
#define KEYS_H

//-----------------------------------------------------------------------------

enum {
  KEY_NULL = 0,
  KEY_1,
  KEY_2,
  KEY_3,
  KEY_4,
  KEY_5,
  KEY_6,
  KEY_7,
  KEY_8,
  KEY_9,
  KEY_10,
  KEY_11,
  KEY_12,
  KEY_13,
  KEY_14,
  KEY_15,
  KEY_16,
  KEY_SOUND,
  KEY_PATTERN,
  KEY_BPM,
  KEY_A, // funct,key,chord.solo,glide
  KEY_B, // fx,style
  KEY_PLAY,
  KEY_WRITE,
};

//-----------------------------------------------------------------------------

int key_init(void);

//-----------------------------------------------------------------------------

#endif // KEYS_H

//-----------------------------------------------------------------------------
