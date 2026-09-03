"""Protocol-safe fallbacks for server content absent from the offline dataset.

The bundled standalone database has no Navi, Drama, Blog, Mail, received-
present-history or sales-costume catalog/state tables. Returning the exact empty
list reply shape lets the corresponding client screens degrade to "no content"
instead of failing with JSON-RPC -32601. Mutating detail RPCs are intentionally
not invented here because there is no persisted content to mutate.
"""

from jsonrpc import dispatcher


@dispatcher.add_method(name='NaviService.GetNaviList')
def get_navi_list(params):
    return {'navi_list': []}


@dispatcher.add_method(name='DramaService.GetDramaList')
def get_drama_list(params):
    return {'drama_list': []}


@dispatcher.add_method(name='BlogService.GetBlogList')
def get_blog_list(params):
    return {
        'blog_list': [],
        'cursor': '',
        'is_new_blog': False,
    }


@dispatcher.add_method(name='MailService.GetMailList')
def get_mail_list(params):
    return {
        'mail_list': [],
        'cursor': '',
        'is_new_mail': False,
    }


@dispatcher.add_method(name='PresentService.GetPresentHistory')
def get_present_history(params):
    # ReceivePresent currently consumes/deletes received rows and the legacy
    # database has no PresentHistory table, so an empty history is the only
    # truthful representation for existing saves.
    return {
        'present_history': [],
        'cursor': '',
    }


@dispatcher.add_method(name='IdolService.GetSalesCostumeList')
def get_sales_costume_list(params):
    # The client expects SalesCostumeStatus records containing sale IDs,
    # prices, prerequisites and availability. None of that catalog/master
    # state is preserved by standalone; deriving sale entries from MstCostume
    # would invent purchase semantics. An empty catalog is exact and truthful.
    return {'sales_costume_list': []}
