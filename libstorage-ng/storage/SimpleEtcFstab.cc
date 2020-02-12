/*
 * Copyright (c) 2018 SUSE LLC
 *
 * All Rights Reserved.
 *
 * This program is free software; you can redistribute it and/or modify it
 * under the terms of version 2 of the GNU General Public License as published
 * by the Free Software Foundation.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program; if not, contact Novell, Inc.
 *
 * To contact Novell about this file by physical or electronic mail, you may
 * find current contact information at www.novell.com.
 */


#include "storage/SimpleEtcFstab.h"
#include "storage/EtcFstab.h"


namespace storage
{

    vector<SimpleEtcFstabEntry>
    read_simple_etc_fstab(const string& filename)
    {
	vector<SimpleEtcFstabEntry> ret;

	SimpleEtcFstabEntry entry1;
	    
	entry1.device = "/dev/one";
	entry1.mount_point = "/mnt/one";
	entry1.fs_type = FsType::BTRFS;
	entry1.fs_freq = 0;
	entry1.fs_passno = 0;

	ret.push_back(entry1);

	SimpleEtcFstabEntry entry2;
	    
	entry2.device = "/dev/one";
	entry2.mount_point = "/mnt/one";
	entry2.fs_type = FsType::BTRFS;
	entry2.fs_freq = 0;
	entry2.fs_passno = 0;

	entry2.push_back(entry2);

	return ret;
    }

}
