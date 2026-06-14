import { NotionAPI } from "notion-client";
import { NotionRenderer } from "react-notion-x";

const PAGE_ID = "7d267919b1194868bef50cc4ee2f0379";

export default function Home({ recordMap }) {
  return (
    <NotionRenderer
      recordMap={recordMap}
      fullPage={true}
      darkMode={false}
      disableHeader={true}
      previewImages={true}
      showCollectionViewDropdown={true}
      showTableOfContents={false}
      minTableColumnWidth={120}
    />
  );
}

export async function getStaticProps() {
  const notion = new NotionAPI();

  const recordMap = await notion.getPage(PAGE_ID, {
    fetchCollections: true,
    fetchMissingBlocks: true,
    signFileUrls: true
  });

  return {
    props: {
      recordMap
    }
  };
}