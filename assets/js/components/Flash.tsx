import { usePage } from "@inertiajs/react"
import React, { useEffect, useState } from "react"

type FlashProps = {
  error?: string
  info?: string
  success?: string
}

export function Flash({ children }: { children: React.ReactNode }) {
  const [visible, setVisible] = useState(false)

  const { props } = usePage()
  const flash = props?.flash as FlashProps

  console.log({ flash })

  useEffect(() => {
    if (flash.info || flash.error || flash.success) {
      setVisible(true)
      const timer = setTimeout(() => {
        setVisible(false)
      }, 4000)
      return () => clearTimeout(timer)
    }
  }, [flash])

  return (
    <main>
      {visible && (
        <p className={`mb-4 ${flashColor(flash)}`}>
          {flash.info || flash.error || flash.success}
        </p>
      )}

      {children}
    </main>
  )
}

function flashColor(flash: FlashProps) {
  if (flash.error) return "text-red-500"
  if (flash.info) return "text-blue-500"
  if (flash.success) return "text-green-500"
  return ""
}
