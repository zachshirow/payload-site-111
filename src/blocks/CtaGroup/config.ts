import type { Block } from 'payload'
import { linkGroup } from '@/fields/linkGroup'

export const CtaGroup: Block = {
  slug: 'cta-group',
  fields: [
    linkGroup({
      overrides: {
        maxRows: 5,
      },
    }),
  ],
  interfaceName: 'CtaGroup',
}
