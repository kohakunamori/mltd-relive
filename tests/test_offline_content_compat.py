import unittest

from mltd.services.offline_content_compat import (
    get_blog_list,
    get_drama_list,
    get_mail_list,
    get_navi_list,
    get_present_history,
    get_shop_item_list,
)


class OfflineContentCompatTest(unittest.TestCase):
    def test_navi_and_drama_empty_shapes(self):
        self.assertEqual(get_navi_list({}), {'navi_list': []})
        self.assertEqual(get_drama_list({}), {'drama_list': []})

    def test_blog_empty_shape(self):
        self.assertEqual(
            get_blog_list({
                'state_cond': 0,
                'mst_idol_id': 0,
                'is_sort_asc': False,
                'cursor': '',
            }),
            {'blog_list': [], 'cursor': '', 'is_new_blog': False},
        )

    def test_mail_empty_shape(self):
        self.assertEqual(
            get_mail_list({
                'mail_state': 0,
                'mst_idol_id': 0,
                'is_sort_asc': False,
                'cursor': '',
            }),
            {'mail_list': [], 'cursor': '', 'is_new_mail': False},
        )

    def test_present_history_empty_shape(self):
        self.assertEqual(
            get_present_history({'cursor': '', 'limit': 50}),
            {'present_history': [], 'cursor': ''},
        )

    def test_shop_item_list_exact_shape(self):
        self.assertEqual(
            get_shop_item_list(),
            {'shop_item_list': []},
        )


if __name__ == '__main__':
    unittest.main(verbosity=2)
