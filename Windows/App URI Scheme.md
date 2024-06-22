```
HKEY_CLASSES_ROOT
   alert
      (Default) = "URL:Alert Protocol"
      URL Protocol = ""
      DefaultIcon
         (Default) = "alert.exe,1"
      shell
         open
            command
               (Default) = "C:\Program Files\Alert\alert.exe" "%1"

Under this new key, the **URL Protocol** string value indicates that this key declares a custom pluggable protocol handler. Without this key, the handler application will not launch. The value should be an empty string.
URL protocol是个识别字段, 不需要value
```


# Test