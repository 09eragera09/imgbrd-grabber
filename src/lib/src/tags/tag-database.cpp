#include "tag-database.h"
#include <utility>
#include "tag-type.h"
#include "tag-type-with-id.h"


TagDatabase::TagDatabase(ReadWritePath typeFile)
	: m_tagTypeDatabase(std::move(typeFile))
{}

bool TagDatabase::open()
{
	m_isOpen = true;
	return true;
}

bool TagDatabase::isOpen() const
{
	return m_isOpen;
}

bool TagDatabase::close()
{
	m_isOpen = false;
	return true;
}

bool TagDatabase::load()
{
	return loadTypes();
}

bool TagDatabase::save()
{
	return m_tagTypeDatabase.save();
}

bool TagDatabase::loadTypes()
{
	return m_tagTypeDatabase.load();
}

void TagDatabase::setTagTypes(const QList<TagTypeWithId> &tagTypes)
{
	m_tagTypeDatabase.setAll(tagTypes);
}

const QMap<int, TagType> &TagDatabase::tagTypes() const
{
	return m_tagTypeDatabase.getAll();
}

int TagDatabase::getTagTypeNumber(const TagType &type)
{
	return m_tagTypeDatabase.get(type, false);
}
