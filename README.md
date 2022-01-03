# mobile_sprout

Mobile app for plant management created for WAPM course @ EITI PW.

## modules

### mobile app

Flutter based app created using material design elements, can be released both for Android and iOS.

### sprout functions

Google Cloud Functions written in Golang. They ask external APIs and factilitate caching on Google Cloud storage.
- `plant-info` used for fetching descriptions and informations for given plant name.
- `plant-image-search` returns plant name for given image.

### pysensor manager

Orchestrator for Humidity sensors written in Python and FastApi.