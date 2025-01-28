export function formatDate(dateString: string | undefined): string {
  if (!dateString) return ""

  const date = new Date(dateString.replace(" ", "T"))
  const now = new Date()
  const isCurrentYear = date.getFullYear() === now.getFullYear()

  return date.toLocaleDateString("en-US", {
    year: isCurrentYear ? undefined : "numeric",
    month: "long",
    day: "numeric",
    hour: "numeric",
    minute: "numeric"
  })
}
