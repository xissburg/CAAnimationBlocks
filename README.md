# CAAnimationBlocks

A category that allows the usage of start and completion blocks in CAAnimation instances, instead of an unpractical delegate.

To use it in your project, just add the CAAnimation+Blocks.h and CAAnimation+Blocks.m files, then just assign a void ^(BOOL) block to the completion property of the CAAnimation instance (which is added to it through a category). You can also assign a start block of the type void ^(void). You can find a working example in RootViewController.m.

