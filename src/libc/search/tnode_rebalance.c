// Copyright (c) 2015 Nuxi, https://nuxi.nl/
//
// This file is distributed under a 2-clause BSD license.
// See the LICENSE file for details.

#include <search.h>
#include <stddef.h>

#include "search_impl.h"

// Computes the AVL balance factor of a node in a tree.
static int tnode_balance(const struct __tnode *n) {
  return (int)(n->__left == NULL ? 0 : n->__left->__height) -
         (int)(n->__right == NULL ? 0 : n->__right->__height);
}

// Updates the height of a node in a tree.
static void tnode_fixup_height(struct __tnode *n) {
  unsigned int height_left = n->__left == NULL ? 0 : n->__left->__height;
  unsigned int height_right = n->__right == NULL ? 0 : n->__right->__height;
  n->__height = (height_left > height_right ? height_left : height_right) + 1;
}

// Performs a left rotation on a node in a tree, while updating the
// height of the altered nodes.
static struct __tnode *tnode_rotate_left(struct __tnode *n) {
  struct __tnode *newroot = n->__right;
  n->__right = newroot->__left;
  newroot->__left = n;
  tnode_fixup_height(n);
  tnode_fixup_height(newroot);
  return newroot;
}

// Performs a right rotation on a node in a tree, while updating the
// height of the altered nodes.
static struct __tnode *tnode_rotate_right(struct __tnode *n) {
  struct __tnode *newroot = n->__left;
  n->__left = newroot->__right;
  newroot->__right = n;
  tnode_fixup_height(n);
  tnode_fixup_height(newroot);
  return newroot;
}

// Restores the AVL tree property on a node in a tree.
struct __tnode *__tnode_rebalance(struct __tnode *n) {
  int balance = tnode_balance(n);
  if (balance < -1) {
    if (tnode_balance(n->__right) > 0) {
      // Right-left case.
      n->__right = tnode_rotate_right(n->__right);
    }
    // Right-right case.
    return tnode_rotate_left(n);
  } else if (balance > 1) {
    if (tnode_balance(n->__left) < 0) {
      // Left-right case.
      n->__left = tnode_rotate_left(n->__left);
    }
    // Left-left case.
    return tnode_rotate_right(n);
  }

  // There is no need to rebalance. At least make sure that the tree
  // height is up to date.
  tnode_fixup_height(n);
  return n;
}
