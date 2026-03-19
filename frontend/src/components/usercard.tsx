import {
    Item,
    ItemContent,
    ItemDescription,
    ItemMedia,
    ItemTitle,
} from "@/components/ui/item"
import { InboxIcon } from "lucide-react"
import { useUserManagement } from "../hooks/useUserManagement"

const user = useUserManagement()

export function ItemVariant() {
    return (
        <div className="flex w-full max-w-md flex-col gap-6">
            <Item variant="muted">
                <ItemMedia variant="icon">
                    <InboxIcon />
                </ItemMedia>
                <ItemContent>
                    <ItemTitle></ItemTitle>
                    <ItemDescription>

                    </ItemDescription>
                </ItemContent>
            </Item>
        </div>
    )
}
