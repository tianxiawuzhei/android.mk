LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)

LOCAL_MODULE := cocos2dlua_shared

LOCAL_MODULE_FILENAME := libcocos2dlua

# 遍历目录及子目录的函数
define walk
    $(wildcard $(1)) $(foreach e, $(wildcard $(1)/*), $(call walk, $(e)))
endef

CUATOM_ALLFILES = $(call walk, $(LOCAL_PATH)/../../../../custom)
CLASS_ALLFILES = $(call walk, $(LOCAL_PATH)/../../Classes)

FILE_LIST := hellolua/main.cpp

# 从所有文件中提取出所有.cpp和.c文件文件
FILE_LIST += $(filter %.cpp %.c, $(CUATOM_ALLFILES))
FILE_LIST += $(filter %.cpp %.c, $(CLASS_ALLFILES))
 
COCOS_DIR := $(LOCAL_PATH)/../../../..
TALKINGDATA_DIR := $(LOCAL_PATH)/../../../../TalkingData

LOCAL_SRC_FILES := $(FILE_LIST:$(LOCAL_PATH)/%=%)
LOCAL_SRC_FILES += ../../../../scripting/lua/cocos2dx_support/LuaCocos2dCgx.cpp
          
FILE_INCLUDES := $(shell find $(LOCAL_PATH)/../../Classes -type d)
FILE_INCLUDES += $(shell find $(LOCAL_PATH)/../../../../custom -type d)

FILE_INCLUDES += $(COCOS_DIR)/cocos2dx/menu_nodes \
				 $(COCOS_DIR)/extensions/GUI/CCEditBox \
				 $(COCOS_DIR)/extensions/AssetsManager \
				 $(COCOS_DIR)/cocos2dx/platform  \
				 $(COCOS_DIR)/cocos2dx  \
				 $(COCOS_DIR)/cocos2dx/touch_dispatcher \
				 $(COCOS_DIR)/cocos2dx/include \
				 $(COCOS_DIR)/cocos2dx/support/tinyxml2 \
				 $(COCOS_DIR)/cocos2dx/cocoa \
				 $(COCOS_DIR)/scripting/lua/cocos2dx_support \
				 $(TALKINGDATA_DIR)/include \
				 $(TALKINGDATA_DIR)/platform/android
				 
				 
  
LOCAL_EXPORT_C_INCLUDES := $(LOCAL_PATH)/../../Classes \

						               
LOCAL_C_INCLUDES := $(FILE_INCLUDES)  					   

LOCAL_STATIC_LIBRARIES := curl_static_prebuilt

LOCAL_WHOLE_STATIC_LIBRARIES := cocos2dx_static
LOCAL_WHOLE_STATIC_LIBRARIES += cocosdenshion_static
LOCAL_WHOLE_STATIC_LIBRARIES += cocos_lua_static
LOCAL_WHOLE_STATIC_LIBRARIES += box2d_static
LOCAL_WHOLE_STATIC_LIBRARIES += chipmunk_static
LOCAL_WHOLE_STATIC_LIBRARIES += cocos_extension_static
LOCAL_WHOLE_STATIC_LIBRARIES += cocos2dx-talkingdata

include $(BUILD_SHARED_LIBRARY)

$(call import-module,cocos2dx)
$(call import-module,CocosDenshion/android)
$(call import-module,scripting/lua/proj.android)
$(call import-module,cocos2dx/platform/third_party/android/prebuilt/libcurl)
$(call import-module,extensions)
$(call import-module,external/Box2D)
$(call import-module,external/chipmunk)
$(call import-module,proj.android/jni)
