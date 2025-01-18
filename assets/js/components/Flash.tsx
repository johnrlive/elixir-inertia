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

  useEffect(() => {
    if (flash.info || flash.error || flash.success) {
      setVisible(true)
      const timer = setTimeout(() => {
        setVisible(false)
      }, 3400)
      return () => clearTimeout(timer)
    }
  }, [flash])

  return (
    <main>
      <p
        className={`mb-4 absolute z-10 top-5 right-5 text-white rounded p-4 ${flashColor(
          flash
        )} ${visible ? "slide-in" : "slide-out"}`}
      >
        {flash.info || flash.error || flash.success}
      </p>

      {children}
    </main>
  )
}

function flashColor(flash: FlashProps) {
  if (flash.error) return "bg-red-500"
  if (flash.info) return "bg-blue-500"
  if (flash.success) return "bg-green-500"
  return ""
}
