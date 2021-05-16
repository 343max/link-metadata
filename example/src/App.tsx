import React, { FC, useEffect, useState } from 'react'
import { Image, SafeAreaView, Text, View } from 'react-native'
import {fetchURLPreview, LinkMetadata} from 'react-native-link-metadata'

const LinkPreview: FC = () => {
  const url = "https://de.wikipedia.org/wiki/Vulcanodon"
  const [linkMetadata, setLinkMetadata] = useState<LinkMetadata | undefined>()
  const [size, setSize] = useState({width: 1, height: 1})

  useEffect(() => {
    const f = async () => {
      setLinkMetadata(await fetchURLPreview(url))
    }

    f()
  }, [])

  useEffect(() => {
    if (linkMetadata?.imageURL) {
      Image.getSize(linkMetadata.imageURL, (width, height) => {
        setSize({width, height})
      })
    }
  }, [linkMetadata])

  if (linkMetadata === undefined) {
    return <Text>Loading...</Text>
  } else {
    const style = {width: 300, height: 300 / size.width * size.height}
    return (<View>
      <Text>{linkMetadata.originalUrl}</Text>
      <Text>{linkMetadata.url}</Text>
      <Text>{linkMetadata.title}</Text>
      {linkMetadata.imageURL !== undefined ?
      <Image source={{uri: linkMetadata.imageURL}} style={style} /> : <></>}
    </View>)
  }

}

const App = () => (
  <SafeAreaView style={{margin: 20}}>
    <LinkPreview />
  </SafeAreaView>
)

export default App
