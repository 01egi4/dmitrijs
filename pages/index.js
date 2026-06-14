import { NotionAPI } from "notion-client";
import { NotionRenderer } from "react-notion-x";
import { getPageTableOfContents } from "notion-utils";

const PAGE_ID = "7d267919b1194868bef50cc4ee2f0379";

export default function Home({ recordMap }) {
  return (
    <main>
      <NotionRenderer
        recordMap={recordMap}
        fullPage={true}
        darkMode={false}
        disableHeader={true}
        showCollectionViewDropdown={true}
        showTableOfContents={false}
        minTableOfContentsItems={100}
      />
    </main>
  );
}

export async function getStaticProps() {
  const notion = new NotionAPI({
    activeUser: undefined,
    authToken: undefined
  });

  const recordMap = await notion.getPage(PAGE_ID, {
    fetchMissingBlocks: true,
    fetchCollections: true,
    signFileUrls: true
  });

  return {
    props: {
      recordMap
    }
  };
}