import { NativeModules } from 'react-native'

export type LinkMetadata = {
  url: string | undefined
  originalUrl: string | undefined
  title: string | undefined
  imageURL: string | undefined
  iconURL: string | undefined
}

export const fetchURLPreview = async (url: string): Promise<LinkMetadata> =>
  await NativeModules.LinkMetadataModule.fetchURLPreview(url)
