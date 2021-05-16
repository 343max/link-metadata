# LPMetadataProvider for react native

Since iOS 13 iOS provides a an API to gether metadata about webpages. This provides this API to React Native Apps.

## Usage

```typescript

import {fetchURLPreview, LinkMetadata} from 'react-native-link-metadata'

const {url, originalUrl, title, imageURL, iconURL} = await fetchURLPreview("https://de.wikipedia.org/wiki/Vulcanodon")

```

## Known Issues

I haven't tested these on Android or iOS versions prior to 13.0.

No idea what will happen you you run it on these, probably your App will crash.