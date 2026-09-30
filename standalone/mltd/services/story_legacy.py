"""Compatibility shims for legacy StoryService method constants.

The corrected Traditional Chinese client exposes ``StoryService.GetSpecialList``
as a method-name constant, but its IL2CPP metadata contains no corresponding
GetSpecialListArgs/GetSpecialListReply type and no request/cache call site.  The
handler is kept deliberately schema-less so a dormant/dynamic client path does
not fail with JSON-RPC -32601 while we avoid inventing a payload the client does
not define.
"""

from jsonrpc import dispatcher


@dispatcher.add_method(name='StoryService.GetSpecialList')
def get_special_list(params):
    return {}
