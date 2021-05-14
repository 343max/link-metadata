import React, { useEffect } from 'react'
import LinkMetadataModule, { Counter } from 'react-native-link-metadata'

const App = () => {
  useEffect(() => {
    console.log(LinkMetadataModule)
  })

  return <Counter />
}

export default App
