class PlantInfoResponses{
  static final String cabbageAnswer1 = """{"data": [{
        "type": "crops",
        "id": "542e9dce63313600020f1300",
        "attributes": {
            "name": "Cabbage",
            "slug": "cabbage",
            "binomial_name": "Brassica oleracea",
            "common_names": ["cabbage", "headed cabbage"],
            "description": "Cabbage is a member of the Brassica family and related to kale, broccoli, brussels sprouts, and cauliflower. It's dense, layered heads grow on stalks and are surrounded by looser outer leaves. It's leaves can be green, white, or purple in color, and smooth or crinkly in texture. Depending on the variety, the head can be round, oblong, or flat. Cabbage prefers cooler temperatures and is best planted in the spring or fall.",
            "sun_requirements": "Full Sun",
            "sowing_method": "Direct seed indoors, transplant seedlings outside after hardening off.",
            "spread": 40,
            "row_spacing": 60,
            "height": 30,
            "processing_pictures": 0,
            "guides_count": 1,
            "main_image_path": "https://s3.amazonaws.com/openfarm-project/production/media/pictures/attachments/5928732ef9f0b200040000c0.jpg?1495823146",
            "taxon": "Species",
            "tags_array": [],
            "growing_degree_days": null,
            "svg_icon": null
        },
        "links": {
            "self": {
                "api": "/api/v1/crops/542e9dce63313600020f1300",
                "website": "/crops/542e9dce63313600020f1300"
            }
        },
        "relationships": {
            "companions": {
                "links": {
                    "related": "/api/v1/crops/542e9dce63313600020f1300/companions"
                }
            },
            "pictures": {
                "links": {
                    "related": "/api/v1/crops/542e9dce63313600020f1300/pictures"
                },
                "data": [{
                    "type": "crops-pictures",
                    "id": "5928732ef9f0b200040000c0"
                }]
            }
        }
    }]}""";

  static final String cabbageAnswer2 = """{"data": [{
        "type": "crops",
        "id": "54afdeff31666300029d0900",
        "attributes": {
            "name": "cabbage",
            "slug": "cabbage-1",
            "binomial_name": "brassica oleracea",
            "common_names": ["cabbage"],
            "description": null,
            "sun_requirements": null,
            "sowing_method": null,
            "spread": null,
            "row_spacing": null,
            "height": null,
            "processing_pictures": 0,
            "guides_count": 0,
            "main_image_path": "/assets/baren_field_square-4a827e5f09156962937eb100e4484f87e1e788f28a7c9daefe2a9297711a562a.jpg",
            "taxon": null,
            "tags_array": [],
            "growing_degree_days": null,
            "svg_icon": null
        },
        "links": {
            "self": {
                "api": "/api/v1/crops/54afdeff31666300029d0900",
                "website": "/crops/54afdeff31666300029d0900"
            }
        },
        "relationships": {
            "companions": {
                "links": {
                    "related": "/api/v1/crops/54afdeff31666300029d0900/companions"
                }
            },
            "pictures": {
                "links": {
                    "related": "/api/v1/crops/54afdeff31666300029d0900/pictures"
                },
                "data": []
            }
        }
    }]}""";
}