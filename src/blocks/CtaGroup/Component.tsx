import { cn } from 'src/utilities/cn'
import React from 'react'
import { CMSLink } from '@/components/Link'
import type { Page } from '@/payload-types'

export type CtaGroupProps = {
  links: {
    link: {
      type?: ('reference' | 'custom') | null;
      newTab?: boolean | null;
      reference?: {
        relationTo: 'pages';
        value: string | Page;
      } | null;
      url?: string | null;
      label: string;
      appearance?: ('default' | 'outline') | null;
    };
    id?: string | null;
  }[]
}

export const CtaGroup: React.FC<CtaGroupProps> = ({ links }) => {
  return (
    <div className={cn('mx-auto my-8 w-full')}>
      {Array.isArray(links) && links.length > 0 && (
            <ul className="flex gap-4">
              {links.map(({ link }, i) => {
                return (
                  <li key={i}>
                    <CMSLink {...link} className="decoration-0" />
                  </li>
                )
              })}
            </ul>
          )}
    </div>
  )
}
