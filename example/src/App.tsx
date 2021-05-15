import React, { FC, useEffect, useState } from 'react'
import { Image, SafeAreaView, Text, View } from 'react-native'
import {fetchURLPreview, LinkMetadata} from 'react-native-link-metadata'

const LinkPreview: FC = () => {
  const url = "https://de.wikipedia.org/wiki/Vulcanodon"
  const [linkMetadata, setLinkMetadata] = useState<LinkMetadata | undefined>()

  useEffect(() => {
    const f = async () => {
      setLinkMetadata(await fetchURLPreview(url))
    }

    f()
  }, [])

  if (linkMetadata === undefined) {
    return <Text>Loading...</Text>
  } else {
    return (<View>
      <Text>{linkMetadata.originalUrl}</Text>
      <Text>{linkMetadata.url}</Text>
      <Text>{linkMetadata.title}</Text>
      {linkMetadata.imageURL !== undefined ?
      <Image source={{uri: linkMetadata.imageURL}} style={{width: "100%"}} /> : <></>}
    </View>)
  }

}

const App = () => {
  return <SafeAreaView><LinkPreview /></SafeAreaView>
}

export default App
