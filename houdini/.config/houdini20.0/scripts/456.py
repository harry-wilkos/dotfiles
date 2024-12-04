import os
import sys
import hou

hou.hscript("autosave on")
hou.setUpdateMode(hou.updateMode.Manual)
sys.path.append("/home/Harry/Twelvefold/hop/")
os.environ["FPS"] = "50"
os.environ["HOP"] = "/home/Harry/Twelvefold/hop_archive"
