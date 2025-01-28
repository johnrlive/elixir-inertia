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
    <div className="relative">
      <div className="fixed z-50 top-0 left-0 w-full flex justify-end p-5 pointer-events-none">
        <p
          className={`text-white rounded p-4 pointer-events-auto ${flashColor(
            flash
          )} ${visible ? "slide-in" : "slide-out"}`}
        >
          {flash.info || flash.error || flash.success}
        </p>
      </div>

      {children}
    </div>
  )
}

function flashColor(flash: FlashProps) {
  if (flash.error) return "bg-red-500"
  if (flash.info) return "bg-blue-500"
  if (flash.success) return "bg-green-500"
  return ""
}

export default Flash
